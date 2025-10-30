import javax.swing.*;
import java.awt.*;

public class ChessBackground extends JPanel {

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        drawBackground(g);
        drawHills(g);
        drawBeach(g);
        drawChessBoard(g);
    }

    private void drawBackground(Graphics g) {
        // Sky gradient
        Graphics2D g2d = (Graphics2D) g;
        GradientPaint sky = new GradientPaint(0, 0, new Color(135, 206, 235), 0, getHeight() / 2, new Color(176, 224, 230));
        g2d.setPaint(sky);
        g2d.fillRect(0, 0, getWidth(), getHeight() / 2);
    }

    private void drawHills(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        int width = getWidth();
        int height = getHeight();

        // Hills base
        g2d.setColor(new Color(34, 139, 34)); // Forest green
        int[] xPoints1 = {0, width / 4, width / 2};
        int[] yPoints1 = {height / 2, height / 3, height / 2};
        g2d.fillPolygon(xPoints1, yPoints1, 3);

        int[] xPoints2 = {width / 3, width / 2, 2 * width / 3};
        int[] yPoints2 = {height / 2, height / 4, height / 2};
        g2d.fillPolygon(xPoints2, yPoints2, 3);

        int[] xPoints3 = {width / 2, 3 * width / 4, width};
        int[] yPoints3 = {height / 2, height / 3, height / 2};
        g2d.fillPolygon(xPoints3, yPoints3, 3);

        // Hills highlights
        g2d.setColor(new Color(50, 205, 50, 150)); // Lighter green with transparency
        int[] xPointsH1 = {width / 8, width / 4, 3 * width / 8};
        int[] yPointsH1 = {height / 2, height / 3 + 10, height / 2};
        g2d.fillPolygon(xPointsH1, yPointsH1, 3);

        int[] xPointsH2 = {width / 2, 5 * width / 8, 3 * width / 4};
        int[] yPointsH2 = {height / 2, height / 3 + 5, height / 2};
        g2d.fillPolygon(xPointsH2, yPointsH2, 3);
    }

    private void drawBeach(Graphics g) {
        Graphics2D g2d = (Graphics2D) g;
        int width = getWidth();
        int height = getHeight();

        // Beach sand
        GradientPaint sand = new GradientPaint(0, height / 2, new Color(238, 214, 175), 0, height, new Color(244, 164, 96));
        g2d.setPaint(sand);
        g2d.fillRect(0, height / 2, width, height / 2);

        // Beach waves
        g2d.setColor(new Color(173, 216, 230, 150)); // Light blue with transparency
        for (int i = 0; i < width; i += 40) {
            g2d.fillOval(i, height / 2 + 10, 40, 20);
        }
    }

    private void drawChessBoard(Graphics g) {
        int boardSize = 320;
        int tileSize = boardSize / 8;
        int startX = (getWidth() - boardSize) / 2;
        int startY = getHeight() - boardSize - 50;

        Graphics2D g2d = (Graphics2D) g;

        // Draw board background
        g2d.setColor(new Color(139, 69, 19)); // Saddle brown
        g2d.fillRect(startX - 10, startY - 10, boardSize + 20, boardSize + 20);

        // Draw tiles
        for (int row = 0; row < 8; row++) {
            for (int col = 0; col < 8; col++) {
                if ((row + col) % 2 == 0) {
                    g2d.setColor(new Color(255, 206, 158)); // Light tile
                } else {
                    g2d.setColor(new Color(209, 139, 71)); // Dark tile
                }
                g2d.fillRect(startX + col * tileSize, startY + row * tileSize, tileSize, tileSize);
            }
        }
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Chess Background with Hills and Beach");
        ChessBackground panel = new ChessBackground();
        frame.add(panel);
        frame.setSize(800, 600);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
