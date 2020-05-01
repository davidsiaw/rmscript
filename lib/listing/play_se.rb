module Listing
	class PlaySe
		def apply(se, volume = 60, pitch = 100)
			[RPG::EventCommand.new(250, 0, [RPG::AudioFile.new(se, volume, pitch)])]
		end
	end
end
