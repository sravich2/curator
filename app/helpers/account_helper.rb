module AccountHelper
  def sandbox
    hash = Hash.new
    Article.all.each do |a|
      a.tags.each do |k, v|
        if v.to_f > 0.8
          if hash[k].nil?
            hash[k] = 1
          else
            hash[k] += 1
          end
        end
      end
    end
    hash.sort_by { |_, v| -v }[0..30].to_h
  end
end