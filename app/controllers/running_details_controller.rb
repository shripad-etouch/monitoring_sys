class RunningDetailsController < ApplicationController
  def index
  	@schedule_details = ScheduleDetail.paginate(page: params[:page], per_page: 5)
  end
end
