require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/category.rb")
require("pry-byebug")

Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()

merchant1 = Merchant.new({"name" => "Leeroy's Weapons Store"})
merchant2 = Merchant.new({"name" => "Taerom Fuiruim Thunderhammer"})
merchant3 = Merchant.new({"name" => "Happily Ever After Potions"})
merchant4 = Merchant.new({"name" => "Milli Featherwhistle's Mounts "})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()

category1 = Category.new({"type" => "Weapons"})
category2 = Category.new({"type" => "Armour"})
category3 = Category.new({"type" => "Potions"})
category4 = Category.new({"type" => "Mounts"})

category1.save()
category2.save()
category3.save()
category4.save()

transaction1 = Transaction.new({"amount" => 25, "date" => '2018-02-28', "merchant_id" => merchant1.id, "category_id" => category1.id})
transaction2 = Transaction.new({"amount" => 60, "date" => '2018-02-24', "merchant_id" => merchant2.id, "category_id" => category2.id})
transaction3 = Transaction.new({"amount" => 32, "date" => '2018-02-26', "merchant_id" => merchant3.id, "category_id" => category3.id})
transaction4 = Transaction.new({"amount" => 124, "date" => '2018-02-28', "merchant_id" => merchant4.id, "category_id" => category4.id})

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()

binding.pry
nil
