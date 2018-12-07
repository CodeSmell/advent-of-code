require_relative "../../lib/day02/InventoryManagement.rb"
require "test/unit"

class Test_InventoryManagement < Test::Unit::TestCase
  def test_countLettersInString_no_repeats
    im = InventoryManagement.new
    countHash = im.countLettersInString("abcdef")
    assert_equal(1, countHash["a"])
    assert_equal(1, countHash["b"])
    assert_equal(1, countHash["c"])
    assert_equal(1, countHash["d"])
    assert_equal(1, countHash["e"])
    assert_equal(1, countHash["f"])
    assert_equal(nil, countHash["g"])
  end

  def test_countLettersInString_mix
    im = InventoryManagement.new
    countHash = im.countLettersInString("bababc")
    assert_equal(2, countHash["a"])
    assert_equal(3, countHash["b"])
    assert_equal(1, countHash["c"])
  end

  def test_countLettersInString_three
    im = InventoryManagement.new
    countHash = im.countLettersInString("ababab")
    assert_equal(3, countHash["a"])
    assert_equal(3, countHash["b"])
  end

  def test_calculateCheckSumCounts_small
    im = InventoryManagement.new
    collectionBoxIds = ["abcdef", "aabcdd"]
    twoCount, threeCount = im.calculateCheckSumCounts(collectionBoxIds)
    assert_equal(1, twoCount)
    assert_equal(0, threeCount)
  end
  
  def test_calculateCheckSumCounts_sample
    im = InventoryManagement.new
    collectionBoxIds = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
    twoCount, threeCount = im.calculateCheckSumCounts(collectionBoxIds)
    assert_equal(4, twoCount)
    assert_equal(3, threeCount)
  end
  
  
  def test_onlyOneCharacterDifference_true_last_character
    im = InventoryManagement.new
    assert_equal(true, im.onlyOneCharacterDifference("ababab", "ababbb"))
  end
  
  def test_onlyOneCharacterDifference_true_mid_character
    im = InventoryManagement.new
    assert_equal(true, im.onlyOneCharacterDifference("ababab", "abaxab"))
  end
  
  def test_onlyOneCharacterDifference_false_last_character
    im = InventoryManagement.new
    assert_equal(false, im.onlyOneCharacterDifference("ababab", "ababbx"))
  end
  
  def test_onlyOneCharacterDifference_false_mid_character
    im = InventoryManagement.new
    assert_equal(false, im.onlyOneCharacterDifference("ababab", "axaxab"))
  end
  
  def test_onlyOneCharacterDifference_same
    im = InventoryManagement.new
    assert_equal(false, im.onlyOneCharacterDifference("ababab", "ababab"))
  end
  
  def test_removeDifferentCharacter
    im = InventoryManagement.new
    assert_equal("abcde", im.removeDifferentCharacter("abcdef", "abcdee"))
  end

  def test_removeDifferentCharacter_sample
    im = InventoryManagement.new
    assert_equal("fgij", im.removeDifferentCharacter("fghij", "fguij"))
  end
  
  def test_findMostlyMatchingBoxIds_sample
    im = InventoryManagement.new
    collectionBoxIds = ["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"]
    boxIdOne, boxIdTwo = im.findMostlyMatchingBoxIds(collectionBoxIds)
    assert_equal("fghij", boxIdOne)
    assert_equal("fguij", boxIdTwo)
  end
end