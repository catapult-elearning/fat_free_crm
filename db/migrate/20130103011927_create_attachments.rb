class CreateAttachments < ActiveRecord::Migration
  def self.up
     create_table :attachments do |t|
       t.references  :user                         # Who uploaded the file.
       t.references  :asset, :polymorphic => true
       t.integer     :doc_file_size                # Uploaded file size
       t.string      :doc_file_name                # Uploaded full file name
       t.string      :doc_content_type             # MIME content type
       t.timestamps
     end
   end

   def self.down
     drop_table :attachments
   end
end
