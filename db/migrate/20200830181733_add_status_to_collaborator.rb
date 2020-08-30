class AddStatusToCollaborator < ActiveRecord::Migration[6.0]
  def change
    add_column :collaborators, :admin, :boolean
  end
end
