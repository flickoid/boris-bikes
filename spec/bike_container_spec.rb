require './lib/bike_container'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do 
	let(:bike) { Bike.new }
	let(:empty_holder) { ContainerHolder.new }
	let(:holder_with_bike) { ContainerHolder.new }
	let(:full_holder) { ContainerHolder.new }
	
	before { holder_with_bike.dock(bike)}
	before { 10.times { full_holder.dock(bike) } }

	context "An empty BikeContainer" do 
		it "should know it's empty" do 
			expect(empty_holder).to be_empty 
		end
		it "should accept a bike" do 
			expect(empty_holder.bike_count).to eq(0)
			empty_holder.dock(bike)
			expect(empty_holder.bike_count).to eq(1)
		end
		
		it "should not release a bike" do
			expect(empty_holder.release(bike)).to be nil 
		end
		
		it "should not accept a non bike" do 
			expect { empty_holder.dock(1) }.to raise_error(RuntimeError, "I only accept bikes!")
		end

		it "should raise an argument error when dock called with no argument" do
			expect { empty_holder.dock }.to raise_error ArgumentError
		end


	end

	context "A Bikecontainer with one bike" do 
		
		it "should know it is not empty" do
			expect(holder_with_bike).not_to be_empty
		end

		it "should release a bike" do
			holder_with_bike.release(bike)
			expect(holder_with_bike.bike_count).to eq(0)
		end

		it "should raise an argument error when release called with no argument" do 
			expect { holder_with_bike.release }.to raise_error ArgumentError
		end

		it "should not release a bike if the argument is not a bike" do
			expect(holder_with_bike.release("string")).to be nil
		end
		
		it "should not release a broken bike" do 
			holder_with_bike.bikes.first.break!
			expect(holder_with_bike.release(bike)).to eq nil
		end
	end

	context "A BikeContainer that is full" do

		it "should not accept a bike" do
			expect { full_holder.dock(bike) }.to raise_error(RuntimeError, "Station is full")
		end

	end

end