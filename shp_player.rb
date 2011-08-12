class SHP_Player < Player
    @@winning_map = {
        :paper => :scissors,
        :rock => :paper,
        :scissors => :rock
    }

    def initialize( opponent )
        # super
        @opponent = opponent
        
        @klass = Kernel.const_get(opponent)
        make_unarmed @klass
        
        @pattern = learning
        @index = 0
    end
    
    def make_unarmed klass
        klass.class_exec{
            def initialize(op) super end
            def choose() :paper end
        }
    end
    
    def learning
        test = @klass.new("Null")
        learns = []
        1000.times do |i|
            learns << test.choose
        end
        learns
    end
    
    def force_paper
        @klass.class_exec{
            def choose() :paper end
        }
        :paper
    end
    
    def guess_next
        guessed = @pattern[@index % @pattern.size ]
        @index += 1
        guessed
    end
    
    def __secret_choose
        guessed = guess_next
        # guessed = force_paper
        my_choice = @@winning_map[guessed]
        my_choice
    end

    def choose
        __secret_choose
    end
end

