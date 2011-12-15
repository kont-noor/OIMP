#require 'RMagick'
require 'ftools'
class Datafile < ActiveRecord::Base
=begin
  #image = the image passed from params[:image]
  #file_type = the confirmed filetype from the controller
  #current_user = various information about the current user
  def self.upload(image)
    #set default cols and rows for our two images that will be created from the uploaded user image
    orig_height  = 640
    orig_width   = 640
    pane_height  = 400
    pane_width   = 400
    thumb_height = 100
    thumb_width  = 100
    
    #read the image from the string
    img = Magick::Image.from_blob(image.read).first
    width = img.rows
    height = img.columns
    format = img.format
    #size = img.size

    #check for correctness
    #return 'wrong format' unless format == 'GIF' && format == 'JPEG' && format == 'PNG'
    #return 'wrong size' if size.to_i > 10 * 1024

    #check image type
    type = Datafile.check_image_type(width, height)    

    #resize
    case
      when type == 'portrait'
        ratio = width.to_f / height.to_f
        orig_width  = orig_width.to_f * ratio
        pane_width  = pane_width.to_f * ratio
        thumb_width = thumb_width.to_f * ratio
      when type == 'landscape'
        ratio = height.to_f / width.to_f
        orig_height  = orig_height.to_f * ratio
        pane_height  = pane_height.to_f * ratio
        thumb_height = thumb_height.to_f * ratio   
      else        
    end
 
    orig_image  = Datafile.get_resized_images(img, orig_height,  orig_width)
    pane_image  = Datafile.get_resized_images(img, pane_height,  pane_width)
    thumb_image = Datafile.get_resized_images(img, thumb_height, thumb_width)

    #set names
    names      = Datafile.get_random_names(img)
    name       = names[0]
    orig_name  = names[1]
    pane_name  = names[2]
    thumb_name = names[3]
    
    #save
    Datafile.save_images(orig_name, orig_image)
    Datafile.save_images(pane_name, pane_image)
    Datafile.save_images(thumb_name, thumb_image)

    return name + '.' + img.format
  end

  def self.check_image_type(width,height)
    
    type = case    
      when height > width
        'portrait'
      when height < width
        'landscape'
      else
        'square'
    end

    return type
  end
  
  def self.get_resized_images(img, height, width)

    image  = img.resize(height, width)
    
    return image
  end

  def self.save_images(name, image)
    #set base directory for the images
    imgDir = "#{::Rails.root.to_s}/public/images/uploaded_images"
    
    image.write "#{imgDir}/#{name}"
  end

  def self.get_random_names(img)
    #set the base name for an image
    random_name = random_name    
    orig_name  = "orig_"  + random_name + '.' + img.format
    pane_name  = "pane_"  + random_name + '.' + img.format
    thumb_name = "thumb_" + random_name + '.' + img.format

    return random_name, orig_name, pane_name, thumb_name
  end
=end
  
  def self.get_random_name
    random_name = ''
    8.times{random_name  << (65 + rand(25)).chr}
	random_name
  end
  
  def self.validation uploaded_file
    max_size = 1024 * 1024 * 10
	return nil if uploaded_file.size > max_size
  end
  
  def self.save_tmp_pdf uploaded_file, name
    file_dir = "#{::Rails.root.to_s}/public/files/"	
	path = file_dir + name + '.pdf'
		
	File.open(path, "wb") do |f|
	  f.write(uploaded_file)
	end
	
	return name
  end

  def self.rip_server_call name
    file_dir    = "#{::Rails.root.to_s}/public/files/"
    path        = file_dir + name + '.pdf'
    console     = 'cmd'
	exe         = 'C://rip_client//rip_client.exe'
	folder      = "#{::Rails.root.to_s}/public/files/converted_pdf/"
	exec_string = "%s %s %s" % [exe, path, folder]
	system exec_string 
  end

  def self.create_images name     
	
    file_dir    = "#{::Rails.root.to_s}/public/files/converted_pdf/"
	
	#paths initialize
	path        = file_dir + name + '_Page001.png'
	orig_path   = file_dir + 'orig_'  + name + '.png'
    pane_path   = file_dir + 'pane_'  + name + '.png'
    thumb_path  = file_dir + 'thumb_' + name + '.png'
	
	Datafile.check_file_status path
	
	File::copy(path, orig_path)
	File::copy(path, thumb_path)
	File::copy(path, pane_path)
  end
  
  def self.check_file_status path
    if !File.exists?(path) || !File.readable_real?(path)
	  self.wait
	  self.check_file_status path
	else
	  self.wait
	  size = 0
	  File.open(path, "r+") do |file|
        size = file.read.size
	  end
	  if size == 0
	    self.wait
	    self.check_file_status path
	  end
	end
  end
  
  def self.wait
    sleep 2
  end
  
  #gotcha should be implemented fully
  def self.garbage_collector images
    file_dir  = "#{::Rails.root.to_s}/public/files/converted_pdf/"
    all_files = Dir.entries file_dir 
	all_files.each do |file|
	  if !file.include?('orig_') && !file.include?('pane_') && !file.include?('thumb_') && !file.include?('svn') && file != '.' && file != '..'
		images.each do |image|
		  image.to_s.delete('.png')
		  unless file.include?(image)
		    path = file_dir + file
	        File.delete(path) if File.exists?(path) && File.readable?(path)
		  end
		end  
	  end
	end
  end
  
end