module SideBarHelper
  def side_bar_items(ru)
    result = []
    result << {
      :name => 'На главную',
      :icon => 'list',
      :controller => :welcome,
      :action => :index
    }

    result << {
     :name => 'Пользователи',
     :controller => :users, :action => :index,
     :icon => 'users',
     :class => 'long'
    } if ru.try(:is_admin?)

    result << {
      :name => 'Заказы',
      :controller => :orders, :action => :index,
      :icon => 'calendar-check-o',
      :class => 'long'
    } unless ru.nil?

    result << {
      :name => 'Промокоды',
      :controller => :promos, :action => :index,
      :icon => 'barcode',
      :class => 'long'
    } if ru.try(:is_admin?)

    result
  end

  def is_open?(ctr, act)
    case ctr.to_s
    when 'users', 'roles', 'orders', 'promos'
      ctr.to_s == controller_name.to_s
    else
      false
    end
  end
end
