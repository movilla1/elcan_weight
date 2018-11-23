# frozen_string_literal: true
require 'reports/manager.rb'
require 'reports/by_driver.rb'

ActiveAdmin.register_page 'Stats' do
  menu priority: 10, label: proc { I18n.t('stats') }
  sidebar I18n.t('help') do
    h3 t('stats_help')
    para t('stats_help_description')
  end
  content title: proc { I18n.t('stats') } do
    panel t('reports') do
      div class: 'row' do
        div class: 'col-md-5' do
          link_to t('report_by_truck'), admin_stats_report_by_truck_path
        end
      end
      div class: 'row' do
        div class: 'col-md-5' do
          link_to t('report_by_driver'), admin_stats_report_by_driver_path
        end
      end
    end
  end

  page_action :report_by_truck do
    render 'admin/stats/by_truck'
  end

  page_action :report_by_driver do
    render 'admin/stats/by_driver'
  end

  page_action :show_report_by_truck, method: :post do
    if params[:truck_id].blank?
      redirect_to(:back, notice: 'No Truck selected')
      return
    end
    mgr = ReportManager.new
    @report_rows = mgr.create_report_by_truck(
      params[:truck_id],
      params[:date_start],
      params[:date_end]
    )
    render 'admin/stats/report_by_truck'
  end

  page_action :show_report_by_driver, method: :post do
    if params[:driver_id].blank?
      redirect_to(:back, notice: 'No driver selected') and return
    end
    rpt = Reports::ByDriver.new(params[:driver_id], params[:date_start], params[:date_end])
    report_rows = rpt.report
    render 'admin/stats/report_by_driver', locals: { report_rows: report_rows }
  end
end
