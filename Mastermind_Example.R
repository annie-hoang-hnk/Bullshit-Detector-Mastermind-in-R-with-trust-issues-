show_rules <- function(){
  cat("GROUP 11 - MASTERMIND GAME\n")
  cat("GUESS THE NUMBERS: 4 DIGITS, EACH FROM 1 TO 6\n")
  cat("⦿ = RIGHT DIGIT, RIGHT PLACE\n")
  cat("○ = RIGHT DIGIT, WRONG PLACE\n")
}

read_guess <- function(){
  repeat{
    input <- readline(prompt = "Enter 4 digits here: ")
    guessnumber <- as.numeric(strsplit(trimws(input), "")[[1]])
    if (length(guessnumber) == 4 && all(guessnumber %in% 1:6) && all(!is.na(guessnumber))){
      return(guessnumber)
    }
    print("Invalid guess! Please put in the correct format:")
  }
}

calculate_feedback <- function(secret, guess){
  blacks <- sum(secret == guess)
  secret_left <- secret[secret != guess]
  guess_left <- guess[secret != guess]
  whites <- 0
  for (a in unique(guess_left)){
    whites <- whites + min(sum(secret_left == a), sum(guess_left == a))
  }
  if (runif(1) < 0.1) {
    blacks <- sample(0:4, 1)
    whites <- sample(0:(4 - blacks), 1)
  }
  c(black = blacks, white = whites)
}

bullshitdetector <- function(){
  show_rules()
  secret <- sample(1:6, 4, replace = TRUE)
  won <- FALSE
  turn <- 0
  
  while (!won){
    turn <- turn + 1
    cat("\nTurn", turn, "\n")
    
    guessnumber <- read_guess()
    feedback <- calculate_feedback(secret, guessnumber)
    blacks <- feedback["black"]
    whites <- feedback["white"]
    
    cat("Your guess:", guessnumber, "\n")
    cat("Feedback  : ")
    if (blacks > 0) cat(rep("⦿", blacks), sep = "")
    if (whites > 0) cat(rep("○", whites), sep = "")
    if (blacks + whites == 0) cat("(Nothing)")
    cat("\n")


    
    if (blacks == 4){
      cat("\nCongrats! You found the secret code in", turn, "turns!\n")
      cat("Secret code:", secret, "\n")
      won <- TRUE
    }
  }
}

bullshitdetector()
