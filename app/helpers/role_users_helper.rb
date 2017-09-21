module RoleUsersHelper

  def link_to_add_role(form, user)
    new_object = RoleUser.new()
    fields = form.fields_for(:role_users, new_object,
      :child_index => 'new_role') do |fr|
      render('users/one_role_user_form', fr: fr, i: 'Новая')
    end
    link_to(?#, class: 'btn btn-info',
        id: 'add_role_link', data: {content: "#{fields}"}) do
      fa_icon("plus") + " Новая роль"
    end
  end
  
  def link_to_remove_role(form)
    form.hidden_field(:_destroy, class: 'remove_fields') +
        link_to(?#, class: 'remove_fields remove_role') do
      fa_icon('times', title: 'Удалить роль') + ' Удалить'
    end
  end
end
