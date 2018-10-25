# frozen_string_literal: true
require 'report_manager'
# Report management controller
class ReportsController < ApplicationController
  def index
    # this shows the index report
  end

  def drivers; end

  def drivers_report
    if params[:driver_id].blank?
      redirect_to(:back, notice: 'No driver selected') and return
    end
    mgr = ::ReportManager.new
    @report_rows = mgr.create_report_by_driver(params[:driver_id])
  end

  def trucks; end

  def trucks_report
    if params[:truck_id].blank?
      redirect_to(:back, notice: 'No Truck selected')
      return
    end
    mgr = ::ReportManager.new
    @rpt = mgr.create_report_by_truck(params[:truck_id], params[:date_start], params[:date_end])
    send_file @rpt.filename, @rpt.file_content
  end
end
