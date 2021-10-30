# Written by Amber Lai Hipp and Ian McNichols
# File Name: Program2.jl
# Programming Assignment 2
# CS 424-01
# October 28, 2021
# Tested on macOS 11.6 using VSCode
# This program reads baseball player information from a given file, calculates statistics, creates a list of players,
# sorts the players by the on-base plus slugging statistic, and prints a report to the screen. It then sorts the players
# by batting average and prints a second report to the screen.

using Base:slug
using Printf

# Print out the team report sorted by value/category passed in
function print_team_report(player_outputs, sort_value, sort_category)
    # Print header info
    println("\n\nPlayers Sorted by ", sort_category, ":\n\n")
    println("     PLAYER NAME     :     AVERAGE  SLUGGING  ONBASE%   OPS")
    println("------------------------------------------------------------")
    # Sort by desired value
    sort!(player_outputs, lt=(x, y) -> isless(y[sort_value], x[sort_value]))
    # Print sorted list
    for i in 1:length(player_outputs)
        tempName = player_outputs[i][1] * ", " * player_outputs[i][2]
        @printf("%20s : %10.3f %8.3f %8.3f %8.3f\n", tempName, player_outputs[i][3], player_outputs[i][4], player_outputs[i][5], player_outputs[i][6])
        print("\n")
    end
    println("------------------------------------------------------------")
end

# Get filename from user, read file, and calculate statistics from variables.
function run_stats()
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
    player_outputs = []

    # Get filename from user
    print("\nEnter the name of your input file: ")
    myfile = nothing
    filename = readline()

    # Read in players from file line-by-line
    try
        myfile = open(filename)
    catch err
        println("\nUnable to open the file: $filename")
	    println("Exiting the program\n")
	    exit(0)
    end
    player_data = readlines(myfile);

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
        # Calculate the statistics of the current player
        push!(averages, (singles[i] + doubles[i] + triples[i] + homeruns[i]) / at_bats[i])
        push!(slugging_percent, (singles[i] + 2 * doubles[i] + 3 * triples[i] + 4 * homeruns[i]) / at_bats[i])
        push!(OBP, (hitByPitch[i] + walks[i] + singles[i] + doubles[i] + triples[i] + homeruns[i]) / plate_appearances[i])
        push!(OPS, (slugging_percent[i] + OBP[i]))
    end

    # Initialize player_outputs array
    for i in 1:length(player_data)
        push!(player_outputs, [names[i][2], names[i][1], averages[i], slugging_percent[i], OBP[i], OPS[i]])
    end
    
    # Print team summary
    println("\n\nBaseball Team Summary:     ", length(player_outputs), " players found in file.")
    return player_outputs
end


function main()
    # Driver function to kick off calculations
    println("Starting new program...\n")

    # Print welcome statement
    println("\nWelcome! This program will read baseball player information from a given file,\n" *
		"calculate the averages for each player, and then print out two reports.")
    
    # Read file and get list of players and statistics
    player_outputs = run_stats()

    # Print report sorted by OPS
    print_team_report(player_outputs, 6, "OPS")

    # Print Report sorted by batting average
    print_team_report(player_outputs, 3, "Batting Average")

    println("\nProgram ended.")
end


# Run the program
main()
