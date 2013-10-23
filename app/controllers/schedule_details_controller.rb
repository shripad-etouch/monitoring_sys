class ScheduleDetailsController < ApplicationController
  def index
  	@schedule_details = ScheduleDetail.include_associated_classes
  end
end
