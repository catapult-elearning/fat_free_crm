class Attachment < ActiveRecord::Base
  belongs_to :user
  belongs_to :asset, :polymorphic => true
  
  has_attached_file :doc, :url => "/attachments/:filename"
  
end