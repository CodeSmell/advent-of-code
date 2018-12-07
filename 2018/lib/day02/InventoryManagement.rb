class InventoryManagement
  def countLettersInString(boxId)
    characterHash = Hash.new

    boxId.each_char do |c|
      characterHash[c] = (characterHash.include?(c)) ? characterHash[c] + 1 : 1
    end

    return characterHash
  end

  #
  # pass in an array of boxId(s)
  # get the two and three letter counts
  #
  def calculateCheckSumCounts(collectionBoxIds)
    twoLetterCount = 0
    threeLetterCount = 0

    collectionBoxIds.each { |boxId|
      characterHash = countLettersInString(boxId)

      foundTwoLetterCombo = false
      foundThreeLetterCombo = false
      characterHash.each do |key, value|
        if (value == 2 && !foundTwoLetterCombo)
          twoLetterCount = twoLetterCount + 1
          foundTwoLetterCombo = true
        elsif (value == 3 && !foundThreeLetterCombo)
          threeLetterCount = threeLetterCount + 1
          foundThreeLetterCombo = true
        end
      end
    }
    return twoLetterCount, threeLetterCount
  end

  def removeDifferentCharacter(boxIdOne, boxIdTwo)
    theDifferentCharIndex = nil
    (0..boxIdOne.length - 1).each do |charIdx|
      if boxIdOne[charIdx] != boxIdTwo[charIdx]
        theDifferentCharIndex = charIdx
      end
    end
    boxIdOne.slice!(theDifferentCharIndex)
    return boxIdOne
  end

  #
  # assuming they are all the same length
  #
  def onlyOneCharacterDifference(boxIdOne, boxIdTwo)
    mismatchCount = 0
    (0..boxIdOne.length - 1).each do |charIdx|
      if boxIdOne[charIdx] != boxIdTwo[charIdx]
        mismatchCount = mismatchCount + 1
      end
      break if mismatchCount > 1
    end

    return mismatchCount == 1 ? true : false
  end

  def compareBoxIdToTheRest(boxId, collectionBoxIds)
    theOtherBoxId = nil
    collectionBoxIds.each {|anotherBoxId|
      if (onlyOneCharacterDifference(boxId, anotherBoxId))
        theOtherBoxId = anotherBoxId
      end
    }
    return theOtherBoxId
  end

  #
  # Star 1
  # pass in an array of boxId(s)
  # calculate the checksum
  #
  def checkSum(collectionBoxIds)
    twoLetterCount, threeLetterCount = calculateCheckSumCounts(collectionBoxIds)
    return twoLetterCount * threeLetterCount
  end

  #
  # Star 2
  # pass in an array of boxId(s)
  # find the box Ids w/ one letter difference
  #
  def findMostlyMatchingBoxIds(collectionBoxIds)
    collectionBoxIds.each.with_index do |boxId, index|
      theOtherBoxId = compareBoxIdToTheRest(boxId, collectionBoxIds)
      if (! theOtherBoxId.nil?)
        return boxId.chomp, theOtherBoxId.chomp
      end
    end
  end

end