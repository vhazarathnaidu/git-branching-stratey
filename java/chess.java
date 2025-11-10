import java.util.Scanner;

// Enum for piece colors
enum Color {
    WHITE, BLACK
}

// Abstract class for chess pieces
abstract class Piece {
    Color color;
    char symbol;

    Piece(Color color, char symbol) {
        this.color = color;
        this.symbol = symbol;
    }

    public Color getColor() {
        return color;
    }

    public char getSymbol() {
        return symbol;
    }

    // Abstract method to validate moves
    public abstract boolean isValidMove(int startRow, int startCol, int endRow, int endCol, Piece[][] board);
}

// Pawn class
class Pawn extends Piece {
    Pawn(Color color) {
        super(color, color == Color.WHITE ? 'P' : 'p');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        int direction = (color == Color.WHITE) ? -1 : 1;
        // Move forward
        if (sc == ec && board[er][ec] == null) {
            if (er - sr == direction) return true;
            // First move can be two steps
            if ((color == Color.WHITE && sr == 6 || color == Color.BLACK && sr == 1) && er - sr == 2 * direction
                    && board[sr + direction][sc] == null) {
                return true;
            }
        }
        // Capture
        if (Math.abs(ec - sc) == 1 && er - sr == direction && board[er][ec] != null
                && board[er][ec].getColor() != color) {
            return true;
        }
        return false;
    }
}

// Rook class
class Rook extends Piece {
    Rook(Color color) {
        super(color, color == Color.WHITE ? 'R' : 'r');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        if (sr != er && sc != ec) return false;
        int rowStep = Integer.compare(er, sr);
        int colStep = Integer.compare(ec, sc);
        int r = sr + rowStep, c = sc + colStep;
        while (r != er || c != ec) {
            if (board[r][c] != null) return false;
            r += rowStep;
            c += colStep;
        }
        return board[er][ec] == null || board[er][ec].getColor() != color;
    }
}

// Knight class
class Knight extends Piece {
    Knight(Color color) {
        super(color, color == Color.WHITE ? 'N' : 'n');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        int dr = Math.abs(er - sr);
        int dc = Math.abs(ec - sc);
        if ((dr == 2 && dc == 1) || (dr == 1 && dc == 2)) {
            return board[er][ec] == null || board[er][ec].getColor() != color;
        }
        return false;
    }
}

// Bishop class
class Bishop extends Piece {
    Bishop(Color color) {
        super(color, color == Color.WHITE ? 'B' : 'b');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        if (Math.abs(er - sr) != Math.abs(ec - sc)) return false;
        int rowStep = Integer.compare(er, sr);
        int colStep = Integer.compare(ec, sc);
        int r = sr + rowStep, c = sc + colStep;
        while (r != er && c != ec) {
            if (board[r][c] != null) return false;
            r += rowStep;
            c += colStep;
        }
        return board[er][ec] == null || board[er][ec].getColor() != color;
    }
}

// Queen class
class Queen extends Piece {
    Queen(Color color) {
        super(color, color == Color.WHITE ? 'Q' : 'q');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        // Queen = Rook + Bishop
        Rook rook = new Rook(color);
        Bishop bishop = new Bishop(color);
        return rook.isValidMove(sr, sc, er, ec, board) || bishop.isValidMove(sr, sc, er, ec, board);
    }
}

// King class
class King extends Piece {
    King(Color color) {
        super(color, color == Color.WHITE ? 'K' : 'k');
    }

    @Override
    public boolean isValidMove(int sr, int sc, int er, int ec, Piece[][] board) {
        int dr = Math.abs(er - sr);
        int dc = Math.abs(ec - sc);
        if (dr <= 1 && dc <= 1) {
            return board[er][ec] == null || board[er][ec].getColor() != color;
        }
        return false;
    }
}

// Main Chess Game
public class ChessGame {
    private Piece[][] board = new Piece[8][8];
    private Color currentTurn = Color.WHITE;

    public ChessGame() {
        setupBoard();
    }

    private void setupBoard() {
        // Pawns
        for (int i = 0; i < 8; i++) {
            board[6][i] = new Pawn(Color.WHITE);
            board[1][i] = new Pawn(Color.BLACK);
        }
        // Rooks
        board[7][0] = new Rook(Color.WHITE);
        board[7][7] = new Rook(Color.WHITE);
        board[0][0] = new Rook(Color.BLACK);
        board[0][7] = new Rook(Color.BLACK);
        // Knights
        board[7][1] = new Knight(Color.WHITE);
        board[7][6] = new Knight(Color.WHITE);
        board[0][1] = new Knight(Color.BLACK);
        board[0][6] = new Knight(Color.BLACK);
        // Bishops
        board[7][2] = new Bishop(Color.WHITE);
        board[7][5] = new Bishop(Color.WHITE);
        board[0][2] = new Bishop(Color.BLACK);
        board[0][5] = new Bishop(Color.BLACK);
        // Queens
        board[7][3] = new Queen(Color.WHITE);
        board[0][3] = new Queen(Color.BLACK);
        // Kings
        board[7][4] = new King(Color.WHITE);
        board[0][4] = new King(Color.BLACK);
    }

    private void printBoard() {
        System.out.println("  a b c d e f g h");
        for (int r = 0; r < 8; r++) {
            System.out.print((8 - r) + " ");
            for (int c = 0; c < 8; c++) {
                if (board[r][c] == null) System.out.print(". ");
                else System.out.print