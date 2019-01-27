# frozen_string_literal: true

require "reports/by_truck.rb"
require "reports/by_driver.rb"
require "reports/daily.rb"

ActiveAdmin.register_page "Stats" do
  menu priority: 10, label: proc { I18n.t("stats") }
  sidebar I18n.t("help") do
    h3 t("stats_help")
    para t("stats_help_description").html_safe
  end
  content title: proc { I18n.t("stats") } do
    panel t("reports") do
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

  page_action :show_report_by_truck, method: :post do
    redirect_to(:back, notice: "No Truck selected") and return if params[:truck_id].blank?
    mgr = Reports::ByTruck.new(params[:truck_id], params[:date_start], params[:date_end])
    report_rows = mgr.report
    by_date_weights = Weight.by_date_and_truck(params[:truck_id],
      params[:date_start], params[:date_end])
    case params[:format].to_s.upcase
    when "HTML"
      render template: "admin/stats/report_by_truck",
        locals: { report_rows: report_rows, truck: Truck.find(params[:truck_id]),
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
    rpt = Reports::ByDriver.new(params[:driver_id], params[:date_start], params[:date_end])
    by_date_weights = Weight.by_date_and_user(params[:driver_id],
      params[:date_start], params[:date_end])
    report_rows = rpt.report
    case params[:format].to_s.upcase
    when "HTML"
      render "admin/stats/report_by_driver",
        locals: {
          report_rows: report_rows,
          driver: User.find(params[:driver_id]),
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
    report_manager = Reports::Daily.new(params[:date_start], params[:date_start])
    report_rows = report_manager.report
    grouped_rows = report_manager.weights_grouped_by_driver
    label_array = grouped_rows.keys.collect &:display_string
    render_format = params[:format]
    case render_format.upcase
    when "HTML"
      render template: "admin/stats/daily_report",
        locals: {
          report_rows: report_rows,
          day_date: Date.strptime(params[:date_start], "%Y-%m-%d"),
          json_data: grouped_rows.values.to_json, json_labels: label_array.to_json
        }
    when "XLSX"
      render template: "admin/stats/daily_report",
        locals: { report_rows: report_rows, day_date: Date.strptime(params[:date_start], "%Y-%m-%d") },
        xlsx: "daily_report_#{Date.current.to_formatted_s(:iso8601)}"
    when "JSON"
      render json: report_rows
    end
  end
end
