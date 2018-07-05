require_relative('../models/transaction')
require_relative('../models/tagtype')
require_relative('../models/merchant')
require('date')

Transaction.delete_all()
TagType.delete_all()
Merchant.delete_all()

merchant1 = Merchant.new({
  "name" => "Tesco"
})

merchant2 = Merchant.new({
  "name" => "Primark"
})

merchant3 = Merchant.new({
  "name" => "John Lewis"
})

merchant4 = Merchant.new({
  "name" => "Argos"
})

merchant5 = Merchant.new({
  "name" => "Dunelm"
})

merchant6 = Merchant.new({
  "name" => "HMV"
})

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()
merchant5.save()
merchant6.save()

tagtype1 = TagType.new({
  "type" => "Food"
})

tagtype2 = TagType.new({
  "type" => "Clothes"
})

tagtype3 = TagType.new({
  "type" => "Music/DVDs"
})

tagtype4 = TagType.new({
  "type" => "Furniture"
})

tagtype5 = TagType.new({
  "type" => "Electrical Goods"
})

tagtype1.save()
tagtype2.save()
tagtype3.save()
tagtype4.save()
tagtype5.save()

transaction1 = Transaction.new({
  "merchant_id" => merchant1.id,
  "value" => 67,
  "tagtype_id" => tagtype1.id,
  "date" => "2017-04-01"
})

transaction2 = Transaction.new({
  "merchant_id" => merchant2.id,
  "value" => 159,
  "tagtype_id" => tagtype2.id,
  "date" => "2017-07-15"
})

transaction3 = Transaction.new({
  "merchant_id" => merchant3.id,
  "value" => 14,
  "tagtype_id" => tagtype1.id,
  "date" => "2017-12-25"
})

transaction4 = Transaction.new({
  "merchant_id" => merchant5.id,
  "value" => 19,
  "tagtype_id" => tagtype2.id,
  "date" => "2017-04-01"
})

transaction5 = Transaction.new({
  "merchant_id" => merchant4.id,
  "value" => 37,
  "tagtype_id" => tagtype5.id,
  "date" => "2017-09-01"
})

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()
