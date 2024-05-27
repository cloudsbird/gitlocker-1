namespace :user do
  desc "Check sales for all users, update pending status, and add sale value to balance"
  task update_sales: :environment do
    seven_days_ago = 7.days.ago

    User.find_each do |user|
      recent_sales = user.sales.where("purchases.created_at < ? AND purchases.pending = ?", seven_days_ago, true)

      total_sale_value = 0

      recent_sales.each do |sale|
        sale.update(pending: false)
        
        total_sale_value += sale.price_cents
      end
      total_sale_value *= 0.9
      total_sale_value /= 100

      user.update(balance: user.balance + total_sale_value) if total_sale_value > 0
      user.update(total_earning: user.total_earning + total_sale_value) if total_sale_value > 0

      puts "Updated sales for user ##{user.id}. Total added to balance: #{total_sale_value} USD."
    end
  end
end
