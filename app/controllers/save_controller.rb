class SaveController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    attributes = []
    attributes = params[:attributes]

    #processing the parameters
    tmp_image_name =  if attributes[:imageName].empty?
                        "#{::Rails.root.to_s}/public/samples/spring/frame.png"
                      else
                        "#{::Rails.root.to_s}/public" + attributes[:imageName].to_s # "#{::Rails.root.to_s}/public/images/uploaded_images" +
                      end

    tmp_image_name.sub!('pane_', 'orig_')
    thumb_image_name = tmp_image_name.sub('orig_', 'thumb_')

    frame_name = (attributes[:styleName].empty?) ? '/samples/spring/frame.png' : attributes[:styleName]
    frame_name = "#{::Rails.root.to_s}/public/uploaded_images"+frame_name.to_s
    frame_name.sub!('_pane', '')

    image       = Magick::Image.ping(tmp_image_name).first
    thumb_image = Magick::Image.ping(thumb_image_name).first

    #recounting image parameters
    frame_width    = (attributes[:styleWidth].empty?)  ? 400 : attributes[:styleWidth]
    frame_height   = (attributes[:styleHeight].empty?) ? 400 : attributes[:styleHeight]
    zoom           = 4

    scale          = (attributes[:scale].empty?) ? 1 : attributes[:scale]
    scale          = scale.to_i * zoom * thumb_image.rows / image.rows

    content_width  = image.rows * scale.to_i
    content_height = image.columns * scale.to_i

    offsetX        = (attributes[:offsetX].empty?) ? 0 : attributes[:offset]
    offsetY        = (attributes[:offsetY]) ? 0 : attributes[:offsetY]
    margin_left    = (frame_width.to_i  - content_width.to_i)  / 2 + offsetX.to_i
    margin_top     = (frame_height.to_i - content_height.to_i) / 2 + offsetY.to_i

    #refining offset because of incorrect rotation
    centerX        = content_width  / 2
    centerY        = content_height / 2
    rotation       = (attributes[:rotation].empty?) ? 0 : attributes[:rotation]
    angle_rad      = (-Math::PI).to_i * rotation.to_i / 180
    centerX1       = centerX.to_f * Math::cos(angle_rad.to_f) + centerY.to_f * Math::sin(angle_rad.to_f)
    centerY1       = centerY.to_f * Math::cos(angle_rad.to_f) - centerX.to_f * Math::sin(angle_rad.to_f)
    dy             = centerY - centerY1
    dx             = centerX - centerX1
    top            = (dy + margin_top).to_i
    left           = (dx + margin_left).to_i

    #write into a file
    fo_name = ''
    8.times{fo_name  << (65 + rand(25)).chr}
    fo_name = 'file' + fo_name

    file = File.new("#{::Rails.root.to_s}/tmp/fo/" + fo_name + '.fo', "w+")
    file.puts <<EOF
        <?xml version="1.0" encoding="ISO-8859-1"?>

	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fox="http://xmlgraphics.apache.org/fop/extensions">

	<fo:layout-master-set>
	  <fo:simple-page-master master-name="Photo" page-height="#{frame_height}pt" page-width="#{frame_width}pt">
		<fo:region-body />
	  </fo:simple-page-master>
	</fo:layout-master-set>

	<fo:page-sequence master-reference="Photo">
	  <fo:flow flow-name="xsl-region-body">
		<fo:block-container fox:transform="rotate(#{rotation})" absolute-position="absolute" top="#{top}pt" left="#{left}pt">
			<fo:block>
				<fo:external-graphic src="url(#{tmp_image_name})" content-width="#{content_width}pt" />
			</fo:block>
		</fo:block-container>
		<fo:block-container absolute-position="absolute" top="-2pt" left="0">
			<fo:block>
				<fo:external-graphic src="url(#{frame_name})" content-width="#{frame_width}pt" content-height="#{frame_height}pt" />
			</fo:block>
		</fo:block-container>
	  </fo:flow>
	</fo:page-sequence>

	</fo:root>
EOF
    file.close

    redirect_to root_url

  end

end
