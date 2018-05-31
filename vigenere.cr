module VigenereCipher
  # encrypt function
  def self.encrypt(text, key, autokey)
    # transforms the text to uppercase
    text = text.upcase.delete('\n')
    givenKey = [] of Char

    # initializes array of characters to be used in the first key.size iterations
    key.each_char do |c|
      givenKey << c.upcase
    end

    # if the user indicates that the cipher should be an autokey cipher, append the plain text at the end of the key
    if (autokey)
      text.each_char do |c|
        givenKey << c
      end
    end

    # initializes the table
    tabulaRecta = tableSetup
    tabulaN = Math.sqrt(tabulaRecta.size).to_i
    shiftChars = tabulaRecta[0].ord

    # empty encrypted text
    encryptedText = ""

    text.each_char_with_index do |c, index|
      key_char = givenKey[index % key.size]
      i = key_char.ord - shiftChars
      j = c.ord - shiftChars
      index = i * tabulaN + j
      encryptedText = encryptedText + tabulaRecta[index]
    end

    return encryptedText
  end

  def self.decrypt(text, key, autokey)
    # transforms the text to uppercase
    text = text.upcase.delete('\n')
    givenKey = [] of Char

    # initializes array of characters to be used in the first key.size iterations
    key.each_char do |c|
      givenKey << c.upcase
    end

    # initializes the table
    tabulaRecta = tableSetup
    tabulaN = Math.sqrt(tabulaRecta.size).to_i
    shiftChars = tabulaRecta[0].ord

    # empty encrypted text
    decryptedText = ""

    text.each_char_with_index do |c, index|
      key_char = givenKey[index % key.size]
      i = key_char.ord - shiftChars
      j = 0
      index = i * tabulaN + j
      encryptedChar = tabulaRecta[index]
      while (encryptedChar != c)
        j = j + 1
        index = i * tabulaN + j
        encryptedChar = tabulaRecta[index]
      end
      foundChar = (j + shiftChars).chr
      decryptedText = decryptedText + foundChar
      # if the cipher is supposed to be an autokey cipher, append the deciphered text at the end of the key
      if (autokey)
        givenKey << foundChar
      end
    end

    return decryptedText
  end

  private def self.tableSetup
    tabulaRecta = [] of Char
    alphabet = [] of Char

    # initializes the alphabet used in the encryption
    (' '..'_').each do |c|
      alphabet << c
    end

    # initializes the tabula recta
    i = 0
    while (i < alphabet.size)
      tabulaRecta << alphabet[i]
      j = (i + 1) % alphabet.size
      while (alphabet[j] != alphabet[i])
        tabulaRecta << alphabet[j]
        j = (j + 1) % alphabet.size
      end
      i = i + 1
    end

    return tabulaRecta
  end
end
