class UploaderController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    session[:images] = (session[:images].nil?) ? [] : session[:images]
    session[:images].push(Datafile.upload params[:file])
    redirect_to root_url
  end

end
