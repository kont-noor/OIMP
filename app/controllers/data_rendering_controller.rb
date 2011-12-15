class DataRenderingController < ApplicationController

  def styles
    wrong_names = ['.','..','.svn']
    folders = Dir.entries('public/samples')
    wrong_names.each do |wrong|
      folders.delete(wrong)
    end
    render :json => folders.to_json
  end
  
  def images
    if session[:images].nil?
      render :text => ''
    else
      images = {}
      images['path'] = "/files/converted_pdf/"
      images['files'] = []
      session[:images].each do |img|
        images['files'].push(img) if File.exists? "#{::Rails.root.to_s}/public/files/converted_pdf/thumb_" + img.to_s      
      end
      render :json => images.to_json
    end
  end

=begin   
  def images
    if session[:images].nil?
      #this line should be delete as soon as possible
      #render :text => '{"path":"images/","files":["rails.png"]}'
      render :text => ''
    else
      images = {}
      images['path'] = "images/uploaded_images/"
      images['files'] = []
      session[:images].each do |img|
        images['files'].push(img) if File.exists? "#{::Rails.root.to_s}/public/images/uploaded_images/orig_" + img.to_s      
      end     
      render :json => images.to_json
    end
  end
=end
  
end