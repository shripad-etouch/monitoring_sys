class RunningDetailsController < ApplicationController
  def index
  	@schedule_details = ScheduleDetail.include_associated_classes.paginate(page: params[:page], per_page: 5)
  end
end
