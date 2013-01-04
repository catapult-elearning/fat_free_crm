class AttachmentsController < ApplicationController
  require 'fileutils'
  def create
    attach_file = params[:attachment][:file] 
    asset_class = params[:attachment][:asset_class]
    asset_id = params[:attachment][:asset_id]
   
    klass = asset_class.constantize
    asset = klass.find(asset_id)
    
    dir_name = Rails.root.join('attachments',asset_class.downcase.pluralize,asset_id) 
    FileUtils.mkdir_p dir_name unless File.directory?(dir_name)
     
    File.open("#{dir_name}/#{attach_file.original_filename}", 'wb') do |file|
      file.write(attach_file.read)
    end 
    
    attachment = Attachment.create
    attachment.asset_id = asset_id
    attachment.asset_type = asset_class
    attachment.doc_file_name = attach_file.original_filename
    attachment.doc_content_type = attach_file.content_type   
    
    attachment.save!
    
    redirect_to asset 
       
  end
  
  def show
    attachment = Attachment.find(params[:id])
    send_file Rails.root.join('attachments',attachment.asset_type.downcase.pluralize,attachment.asset_id.to_s,attachment.doc_file_name), :type => attachment.doc_content_type
    
    # klass = attachment.asset_type.constantize
    #    asset = klass.find(attachment.asset_id)
    # render :nothing => true
  end
end