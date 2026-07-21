import chess

def print_board(board):
    print(board.unicode(invert_color=True, borders=True))
    print()

def main():
    board = chess.Board()
    print("♞ Welcome to Python Chess! ♞")
    print_board(board)

    while not board.is_game_over():
        print("Turn:", "White" if board.turn == chess.WHITE else "Black")
        move = input("Enter your move (e.g., e2e4 or 'q' to quit): ").strip()

        if move.lower() == 'q':
            print("Game ended.")
            break

        try:
            board.push_san(move)
        except ValueError:
            print("❌ Invalid move! Try again.")
            continue

        print_board(board)

    if board.is_checkmate():
        print("🏁 Checkmate! Winner:", "White" if not board.turn else "Black")
    elif board.is_stalemate():
        print("🤝 Stalemate!")
    elif board.is_insufficient_material():
        print("⚖️ Draw (insufficient material)")
    elif board.is_seventyfive_moves():
        print("⚖️ Draw (75-move rule)")
    elif board.is_fivefold_repetition():
        print("⚖️ Draw (fivefold repetition)")

if __name__ == "__main__":
    main()
