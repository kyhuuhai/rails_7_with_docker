ActiveAdmin.register Post do
  permit_params :user_id, :title, :content

  index do
    selectable_column
    id_column
    column :user_id
    column :title
    column :content

    actions
  end

  filter :user_id
  filter :title
  filter :content

  form do |f|
    f.inputs do
      f.input :user_id
      f.input :title
      f.input :content
    end
    f.actions
  end
end
