class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  skip_before_action :authorize_request, only: [:index, :show]

  # GET /events
  def index
    events = Event.all
    render json: events, each_serializer: EventSerializer, status: :ok
  end

  # POST /events
  def create
    upload = upload_image
    event = Event.create!(event_params.except(:file).merge(image_url: upload['secure_url']))
    json_response({event: event}, :created)
  end

  # GET /events/:id
  def show
    json_response({event: @event}, :ok)
  end

  # PUT /events/:id
  def update
    @event.update(event_params)
    head :no_content
  end

  # DELETE /events/:id
  def destroy
    @event.destroy
    head :no_content
  end

  private

  def event_params
    # whitelist params
    params.permit(
      :name,
      :description,
      :start_date,
      :end_date,
      file: [ :src, :name ]
    )
  end

  def upload_image
    file_name = event_params[:file][:name]
    Cloudinary::Uploader.upload(event_params[:file][:src], :public_id => file_name, :resource_type => 'image')
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
