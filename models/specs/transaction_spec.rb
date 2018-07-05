require("minitest/autorun")
require("minitest/rg")
require_relative('../transaction')
require_relative('../tagtype')
require_relative('../merchant')
require('date')


class MoneyCashboardTest < MiniTest::Test

  def setup
    @merchant1 = Merchant.new({
      "name" => "Tesco"
    })
    @tagtype1 = TagType.new({
      "type" => "Food"
    })
    @transaction1 = Transaction.new({
      "merchant_id" => @merchant1.id,
      "value" => 67,
      "tagtype_id" => @tagtype1.id,
      "date" => "2017-04-01"
    })
  end


  def test_merchant_initialize
    assert_equal("Tesco", @merchant1.name)
  end

  def test_tagtype_initialize
    assert_equal("Food", @tagtype1.type)
  end

  def test_transaction_initialize
    assert_equal(@merchant1.id, @transaction1.merchant_id)
    assert_equal(67, @transaction1.value)
    assert_equal(@tagtype1.id, @transaction1.tagtype_id)
    assert_equal("2017-04-01", @transaction1.date)
  end

  def test_totals_match_breakdown_totals
    overall_total = Transaction.get_total_value()
    tagtype_total_array = Transaction.get_total_values_by_tag()
    tagtype_total = 0

    for total_hash in tagtype_total_array
      tagtype_total += total_hash["total"]
    end

    annual_totals_array = Transaction.get_spending_by_year_and_month()
    annual_total = annual_totals_array.sum

    assert_equal(overall_total,tagtype_total)

    assert_equal(overall_total, annual_total)

  end

end
