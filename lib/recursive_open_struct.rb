class RecursiveOpenStruct < OpenStruct

  def initialize(hash)
    super(hash.each_with_object({}) do |(key, val), memo|
      memo[key] = val.is_a?(Hash) ? self.class.new(val) : val
    end)
  end

end
