class TranslatorController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index

  	#return if params[:file].nil?
  	uploaded_file = params[:file].read
  	#return if Datafile.validation(uploaded_file).nil?

  	name = Datafile.get_random_name

  	#image processing
  	Datafile.save_tmp_pdf      uploaded_file, name
  	Datafile.rip_server_call   name
  	Datafile.create_images     name

  	session[:images] = (session[:images].nil?) ? [] : session[:images]
    session[:images].push(name + '.png')

  	Datafile.garbage_collector session[:images]
  	redirect_to root_url
  end
end
