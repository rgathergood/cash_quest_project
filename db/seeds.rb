require_relative("../models/transaction.rb")
require_relative("../models/merchant.rb")
require_relative("../models/tag.rb")
require("pry-byebug")

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

merchant1 = Merchant.new({"name" => "Leeroy's Weapons Store"})
merchant2 = Merchant.new({"name" => "Taerom Fuiruim's Thunderhammer Smithy"})
merchant3 = Merchant.new({"name" => "Happily Ever After Potions"})
merchant4 = Merchant.new({"name" => "Milli Featherwhistle's Mounts "})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()

tag1 = Tag.new({"type" => "Weapons"})
tag2 = Tag.new({"type" => "Armour"})
tag3 = Tag.new({"type" => "Potions"})
tag4 = Tag.new({"type" => "Mounts"})

tag1.save()
tag2.save()
tag3.save()
tag4.save()

transaction1 = Transaction.new({"amount" => 25, "merchant_id" => merchant1.id, "tag_id" => tag1.id})
transaction2 = Transaction.new({"amount" => 60, "merchant_id" => merchant2.id, "tag_id" => tag2.id})
transaction3 = Transaction.new({"amount" => 32, "merchant_id" => merchant3.id, "tag_id" => tag3.id})
transaction4 = Transaction.new({"amount" => 124, "merchant_id" => merchant4.id, "tag_id" => tag4.id})

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()

binding.pry
nil
