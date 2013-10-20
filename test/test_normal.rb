puts File.dirname(__FILE__)
require File.dirname(__FILE__) + '/test_helper.rb' 


class NormalTest <  Minitest::Test

  def setup
    @f=Randprize::Base.new
    @pm=Randprize::ManagePrizes.new
    @headstails={ "T"=> {'odds'=> 2,'name'=>'win tails','value'=>0},"H"=> {'odds'=> 2,'name'=>'win heads','value'=>1}}
    @dice={}
    1.upto(6) {|i| @dice[i.to_s]= {'odds'=> 6,'name'=>"rolled #{i}",'value'=>1} }
    @large={ "GP"=> {'odds'=> 100,'name'=>'grandprize','value'=>50000},"H"=> {'odds'=> 'REMAINING','name'=>'win heads','value'=>1}}
     @exlarge={ "GP"=> {'odds'=> 50000,'name'=>'grandprize','value'=>50000},"2nd"=> {'odds'=> 5000,'name'=>'2ndprize','value'=>50000},"H"=> {'odds'=> 'REMAINING','name'=>'win heads','value'=>0}}
    
  end
  
  
   def test_randomprize_forrandom
       steps=5000
       count=0
       1.upto(steps)  do
        @pm.prize_list(@headstails)
        prizes=[]
        @pm.myprizelist.each {|k| #puts "K is #{k}"
                             prizes << k[1]}
        aprize=@pm.random_prize
        assert prizes.include?(aprize), "prize should be from the list"    
        #puts  "count #{count} aprize #{aprize}"
        count=aprize['value']+count     
        end
       ratio=(count.to_f/steps)*100
       assert (49..51).include?(ratio.round), "ratio wrong #{ratio.round} count #{count}"
    end
     def test_dize
         steps=5000
         count=0
          hcount={}
         1.upto(6)  {|i| hcount["rolled #{i}"]=0}
        
         1.upto(steps)  do
          @pm.prize_list(@dice)
          prizes=[]
          @pm.myprizelist.each {|k| #puts "K is #{k}"
                               prizes << k[1]}
          aprize=@pm.random_prize
          assert prizes.include?(aprize), "prize should be from the list"    
          #puts  "count #{count} aprize #{aprize}"
          hcount[aprize['name']]=hcount[aprize['name']]+1     
          end
        # ratio=(count.to_f/steps)*100
        # assert (49..51).include?(ratio.round), "ratio wrong #{ratio.round} count #{count}"
      end
    
  
 
 

end
