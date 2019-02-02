# frozen_string_literal: true

require "reports/by_truck"
require "reports/by_driver"
require "reports/driver_performance"
require "reports/daily"

ActiveAdmin.register_page "Stats" do
  menu priority: 10, label: proc { I18n.t("stats") }
  sidebar I18n.t("help") do
    h3 t("stats_help")
    para t("stats_help_description").html_safe
  end
  content title: proc { I18n.t("stats") } do
    panel t("general_reports") do
      div class: "row" do
        div class: "col-md-3" do
          link_to t("report_by_truck"),
            admin_stats_report_by_truck_path,
            class: "btn btn-default"
        end
        div class: "col-md-3" do
          link_to t("report_by_driver"),
            admin_stats_report_by_driver_path,
            class: "btn btn-default"
        end
        div class: "col-md-3" do
          link_to t("daily_report"),
            admin_stats_daily_report_path,
            class: "btn btn-default"
        end
      end
    end
    br
    panel t("performance_reports") do
      div class: "row" do
        div class: "col-md-3" do
          link_to t("driver_performance_report"),
            admin_stats_driver_performance_report_path,
            class: "btn btn-default"
        end
      end
    end
  end

  page_action :report_by_truck do
    render "admin/stats/by_truck"
  end

  page_action :report_by_driver do
    render "admin/stats/by_driver"
  end

  page_action :daily_report do
    render "admin/stats/daily_report_form"
  end

  page_action :driver_performance_report do
    render "admin/stats/driver_performance_form"
  end

  page_action :show_report_by_truck, method: :post do
    redirect_to(:back, notice: "No Truck selected") and return if params[:truck_id].blank?
    dates_from_params(params)
    mgr = Reports::ByTruck.new(params[:truck_id], params[:date_start], params[:date_end])
    report_rows = mgr.report
    redirect_to :stats_no_data, notice: I18n.t("no_data_for_report") and return if report_rows.blank?
    by_date_weights = Weight.by_date_and_truck(params[:truck_id],
      @start_date.beginning_of_day, @end_date.end_of_day)
    case params[:format].to_s.upcase
    when "HTML"
      render template: "admin/stats/report_by_truck",
        locals: { report_rows: report_rows, truck: Truck.find(params[:truck_id]),
                  date_start: params[:date_start], date_end: params[:date_end],
                  json_data: by_date_weights.values.to_json,
                  json_labels: by_date_weights.keys.to_json }
    when "XLSX"
      render template: "admin/stats/report_by_truck",
        locals: { report_rows: report_rows, truck: truck,
                  total_weight: total_weight },
        xlsx: "report_by_truck_#{Date.current.to_formatted_s(:iso8601)}"
    when "JSON"
      render json: [@report_rows, truck: truck.display_string, total_weight: total_weight]
    end
  end

  page_action :show_report_by_driver, method: :post do
    if params[:driver_id].blank?
      redirect_to(:back, notice: I18n.t("no_driver_selected")) and return
    end
    dates_from_params(params)
    rpt = Reports::ByDriver.new(params[:driver_id], @start_date.beginning_of_day, @end_date.end_of_day)
    report_rows = rpt.report
    redirect_to :back, notice: I18n.t("no_data_for_report") and return if report_rows.blank?
    by_date_weights = Weight.by_date_and_user(params[:driver_id],
      @start_date.beginning_of_day, @end_date.end_of_day)
    case params[:format].to_s.upcase
    when "HTML"
      render "admin/stats/report_by_driver",
        locals: {
          report_rows: report_rows, driver: User.find(params[:driver_id]),
          date_start: params[:date_start], date_end: params[:date_end],
          json_data: by_date_weights.values.to_json,
          json_labels: by_date_weights.keys.to_json
        }
    when "XLSX"
      render "admin/stats/report_by_driver",
        xlsx: "report_by_driver_#{Date.current.to_formatted_s(:iso8601)}",
        locals: { report_rows: report_rows }
    when "JSON"
      render json: @report_rows
    end
  end

  page_action :daily_report_render, method: :post do
    dates_from_params(params)
    report_manager = Reports::Daily.new(@start_date)
    report_rows = report_manager.report
    redirect_to :back, notice: I18n.t("no_data_for_report") and return if report_rows.blank?
    grouped_rows = Weight.grouped_by_driver(@start_date.beginning_of_day,
      @start_date.end_of_day)
    label_array = grouped_rows.keys.collect { |x| User.find(x).display_string }
    render_format = params[:format].to_s
    case render_format.upcase
    when "HTML"
      render template: "admin/stats/daily_report",
        locals: {
          report_rows: report_rows,
          day_date: @start_date,
          json_data: grouped_rows.values.to_json, json_labels: label_array.to_json
        }
    when "XLSX"
      render template: "admin/stats/daily_report",
        locals: { report_rows: report_rows, day_date: @start_date },
        xlsx: "daily_report_#{Date.current.to_formatted_s(:iso8601)}"
    when "JSON"
      render json: report_rows
    end
  end

  page_action :driver_performance_report_render, method: :post do
    dates_from_params(params)
    report_manager = Reports::DriverPerformance.new(@start_date.beginning_of_day,
      @end_date.end_of_day)
    report_rows = report_manager.report
    if report_rows[2].count < 1
      redirect_to :back, notice: I18n.t("no_data_for_report") and return
    end
    label_array = report_rows[2].keys.collect &:display_string
    case params[:format].to_s.upcase
    when "HTML"
      render template: "admin/stats/driver_performance_report",
        locals: {
          report_rows: report_rows, start_date: @start_date, end_date: @end_date,
          json_data: report_rows[2].values.to_json, json_labels: label_array.to_json
        }
    when "XLSX"
      render template: "admin/stats/driver_performance_report.xlsx",
        locals: {
          report_rows: report_rows, start_date: @start_date, end_date: @end_date
        },
        xlsx: "driver_performance_report_#{Date.current.to_formatted_s(:iso8601)}"
    when "JSON"
      render json: report_rows
    end
  end

  controller do
    def dates_from_params(params)
      @start_date = Date.strptime(params[:date_start], "%Y-%m-%d") if params[:date_start].present?
      @end_date = Date.strptime(params[:date_end], "%Y-%m-%d") if params[:date_end].present?
    end
  end
end
