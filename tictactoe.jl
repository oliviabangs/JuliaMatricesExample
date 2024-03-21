#Global variables
currentBoard = fill(' ', 3, 3)
currentPlayer = 'X'
numPlays = 0

#Helpful game state function to print to the user
function checkGameStatus()
    println("It is player ", currentPlayer, "'s turn.")
    println("The board is currently: ")
    printBoard(currentBoard)
end

#Resets the board and has the other player start first
function playAgain()
    global currentBoard = fill(' ', 3, 3)
    global numPlays += 1
    if numPlays % 2 == 1
        global currentPlayer = 'O'
    else 
        global currentPlayer = 'X'
    end
    println("Board reset. It's player ", currentPlayer, "'s turn to start. Call makeMove().")
end

#Handles the game play logic
function makeMove(xPos, yPos)
    #Reiterating game state messages if they try to keep playing
    if checkWin('X')
        println("Game play over. Player X won. Call playAgain() to restart.")
    elseif checkWin('O')
        println("Game play over. Player O won. Call playAgain() to restart.")
    elseif !checkMoreMoves()
        println("No more moves possible. Call playAgain() to restart.")
    else 
        if checkMovePossible(xPos, yPos)
            updateBoard!(xPos, yPos)
            println("New status of the board.")
            printBoard()

            #Switching to the next player
            if currentPlayer == 'X' 
                global currentPlayer = 'O'
            else 
                global currentPlayer = 'X'
            end

            #Printing any messages based on the new game state
            if checkWin('X')
                println("Game play over. Player X won. Call playAgain() to restart.")
            elseif checkWin('O')
                println("Game play over. Player O won. Call playAgain() to restart.")
            elseif !checkMoreMoves()
                println("No more moves possible. Call playAgain() to restart.")
            else
                println(currentPlayer, "'s turn is next.")
            end
        else 
            println("Cannot make the move.")
        end
    end
end

function printBoard()
    for i in 1:3
        for j in 1:3
            print(" ", currentBoard[i,j], " ")
            if j == 1 || j == 2
                print(" | ")   
            end
        end
        println()
        if i == 1 || i == 2 
            println("---------------")
        end
    end
end

#Takes a move and changes the board if its valid
function updateBoard!(xPos, yPos)
    if checkMovePossible(xPos, yPos)
        global currentBoard[xPos, yPos] = currentPlayer
    else
        println("Error. Spot already occupied.")
    end
end

function checkWin(player)
    #Negative diagonal check
    if currentBoard[1,1] == player && currentBoard[2,2] == player && currentBoard[3,3] == player
        true
    #Positive diagonal check
    elseif currentBoard[3,1] == player && currentBoard[2,2] == player && currentBoard[1,3] == player
        true
    #Column checks
    elseif count(i->(i==player), currentBoard[:,1]) == 3 || count(i->(i==player), currentBoard[:,2]) == 3 || count(i->(i==player), currentBoard[:,3]) == 3 
        true
    #Row checks
    elseif count(i->(i==player), currentBoard[1,:]) == 3 || count(i->(i==player), currentBoard[2,:]) == 3 || count(i->(i==player), currentBoard[3,:]) == 3 
        true 
    else 
        false
    end 
end


function checkMoreMoves()
    #Checks how many (empty) spots on the board that predicate returns true for
    if count(i->(i==' '), currentBoard) > 0 
        true
    else
        false
    end
end

function checkMovePossible(xPos, yPos)
    #Bounds checking
    if xPos < 1 || xPos > 3 || yPos < 1 || yPos > 3
        false
    #Occupied checking
    elseif currentBoard[xPos, yPos] != 'O' && currentBoard[xPos, yPos] != 'X'
        true
    else 
        false
    end
end