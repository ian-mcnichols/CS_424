# Written by Amber Lai Hipp and Ian McNichols
# File Name: Project2.jl
# Programming Assignment 2
# CS 424-01
# October 28, 2021
# Tested on macOS 11.6 using VSCode
# This program reads baseball player information from a given file, calculates statistics, creates a list of players,
# sorts the players by the on-base plus slugging statistic, and prints a report to the screen. It then sorts the players
# by batting average and prints a second report to the screen.

using Base: slug
using Printf


function print_teams(outputs)
    println("Baseball Team Summary:     ", length(outputs), " players found in file.\n\n")

    println("Players Sorted by OPS:\n\n")
    println("     PLAYER NAME     :     AVERAGE  SLUGGING  ONBASE%   OPS")
    println("------------------------------------------------------------")
    # Sort by OPS
    sort!(outputs, lt=(x,y)->isless(y[6], x[6]))
    for i in 1:length(outputs)
        tempName = outputs[i][1] * ", " * outputs[i][2]
        @printf("%20s : %10.3f %8.3f %8.3f %8.3f\n", tempName, outputs[i][3], outputs[i][4], outputs[i][5], outputs[i][6])
        print("\n")
    end
    println("------------------------------------------------------------")


    println("\n\nPlayers Sorted by Batting Average:\n\n")
    println("     PLAYER NAME     :     AVERAGE  SLUGGING  ONBASE%   OPS")
    println("------------------------------------------------------------")
    # Sort by Batting averages
    sort!(outputs, lt=(x,y)->isless(y[3], x[3]))
    for i in 1:length(outputs)
        tempName = outputs[i][1] * ", " * outputs[i][2]
        @printf("%20s : %10.3f %8.3f %8.3f %8.3f\n", tempName, outputs[i][3], outputs[i][4], outputs[i][5], outputs[i][6])
        print("\n")
    end
    println("------------------------------------------------------------")
end


function read_file(filename)
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
    player_data = readlines(filename);
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
        push!(averages, (singles[i] + doubles[i] + triples[i] + homeruns[i]) / at_bats[i])
        push!(slugging_percent, (singles[i] + 2*doubles[i] + 3*triples[i] + 4*homeruns[i]) / at_bats[i])
        push!(OBP, (hitByPitch[i] + walks[i] + singles[i] + doubles[i] + triples[i] + homeruns[i]) / plate_appearances[i])
        push!(OPS, (slugging_percent[i] + OBP[i]))
    end
    for i in 1:length(player_data)
        push!(outputs, [names[i][2], names[i][1], averages[i], slugging_percent[i], OBP[i], OPS[i]])
    end
    
return outputs
end


function main()
    println("Starting new program\n")
    outputs = read_file("C://Users//ian//Desktop//Courses//CS 424//playerInfo.txt")
    print_teams(outputs)
    println("\nProgram ended.")
end


# Run the program
main()