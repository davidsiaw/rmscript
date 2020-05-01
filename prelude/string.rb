# Extra string funcs
class String
  def camelize
    return '' if self.length == 0

    camelized = ""
    up = true
    self.split('').each do |chr|
      if up
        camelized += chr.upcase
      elsif chr == '_'
        up = true
        next
      elsif chr == '/'
        camelized += '::'
        up = true
        next
      else
        camelized += chr
      end
      up = false
    end
    camelized
  end

  def underscore
    return '' if self.length == 0

    str = self.dup
    if str[0..1] == '::'
      str = str[2..-1]
    end

    result = str[0..0].downcase
    last = ''
    suppress = false
    str[1..-1].split('').each do |chr|

      if last == ':' && chr == ':'
        result = result[0..-2] + '/'
        suppress = true
        next
      end

      suppress = true if last == '_'

      if chr.downcase != chr
        result += '_' unless suppress
        result += chr.downcase
        suppress = false
      else
        result += chr
      end
      last = chr
    end

    result
  end
end
