using Base: slug
println("Starting new program\n")
# Declare variable lists
names = []
plate_appearances = []
at_bats = []
singles = []
doubles = []
triples = []
homeruns = []
walks = []
hitByPitch = []
# Statistic lists
averages = []
slugging_percent = []
OBP = []
OPS = []
# Will hold sublists of each player with their calculated statistics
outputs = []
# Read in players from file line-by-line
player_data = readlines("C://Users//ian//Desktop//Courses//CS 424//batters.txt");
# Add values from file to lists
for player in player_data
    # Split the player information and add it to each of the variable lists
    player = split(player, " ")
    push!(names, [player[1], player[2]])
    push!(plate_appearances, parse(Float64, player[3]))
    push!(at_bats, parse(Float64, player[4]))
    push!(singles, parse(Float64, player[5]))
    push!(doubles, parse(Float64, player[6]))
    push!(triples, parse(Float64, player[7]))
    push!(homeruns, parse(Float64, player[8]))
    push!(walks, parse(Float64, player[9]))
    push!(hitByPitch, parse(Float64, player[10]))
end

# Initialize statistics arrays
for i in 1:length(player_data)
    # Calculate the statistics of the current batter and add it to the outputs
    push!(averages, round((singles[i] + doubles[i] + triples[i] + homeruns[i]) / at_bats[i], digits=3))
    push!(slugging_percent, round((singles[i] + 2*doubles[i] + 3*triples[i] + 4*homeruns[i]) / at_bats[i], digits=3))
    push!(OBP, round((hitByPitch[i] + walks[i] + singles[i] + doubles[i] + triples[i] + homeruns[i]) / plate_appearances[i], digits=3))
    push!(OPS, round(slugging_percent[i] + OBP[i], digits= 3))
end

# Print statistics
for i in 1:length(player_data)
    push!(outputs, [names[i][2], names[i][1],  averages[i], slugging_percent[i], OBP[i], OPS[i]])
    #println(names[i][2], ", ", names[i][1],  " ", averages[i], " ", slugging_percent[i], " ", OBP[i], " ", OPS[i])
end

println("BASEBALL TEAM REPORT --- ", length(player_data), " PLAYERS FOUND IN FILE")
println("   PLAYER NAME     :   AVERAGE     SLUGGING    ONBASE%     OPS")
println("--------------------------------------------------------------------")
# Sort by OPS
sort!(outputs, lt=(x,y)->isless(y[6], x[6]))
for i in 1:length(player_data)
    for j in 1:length(outputs)
        print(outputs[i][j], " ")
    end
    print("\n")
end
println("   PLAYER NAME     :   AVERAGE     SLUGGING    ONBASE%     OPS")
println("--------------------------------------------------------------------")
# Sort by Batting averages
sort!(outputs, lt=(x,y)->isless(y[3], x[3]))
for i in 1:length(player_data)
    for j in 1:length(outputs)
        print(outputs[i][j], " ")
    end
    print("\n")
end

println("\nProgram ended.")
