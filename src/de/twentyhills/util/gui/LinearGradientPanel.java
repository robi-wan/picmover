/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package de.twentyhills.util.gui;

import com.jidesoft.swing.JideSwingUtilities;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.LayoutManager;
import java.awt.Rectangle;
import javax.swing.JPanel;

/**
 *
 * @author ntrs
 */
public class LinearGradientPanel extends JPanel {


    //new Color(0xEEE), 0, getHeight(), new Color(0x9AA)
    private Color endColor = new Color(0x99AAAA);
    private Color startColor = new Color(0xEEEEEE);
    private boolean vertical = true;

    /**
     * Creates a new JPanel with the specified layout manager and buffering
     * strategy.
     *
     * @param layout  the LayoutManager to use
     * @param isDoubleBuffered  a boolean, true for double-buffering, which
     *        uses additional memory space to achieve fast, flicker-free
     *        updates
     */
    public LinearGradientPanel(LayoutManager layout, boolean isDoubleBuffered) {
        super(layout, isDoubleBuffered);
    }

    /**
     * Create a new buffered JPanel with the specified layout manager
     *
     * @param layout  the LayoutManager to use
     */
    public LinearGradientPanel(LayoutManager layout) {
        super(layout);
    }

    /**
     * Creates a new <code>JPanel</code> with <code>FlowLayout</code>
     * and the specified buffering strategy.
     * If <code>isDoubleBuffered</code> is true, the <code>JPanel</code>
     * will use a double buffer.
     *
     * @param isDoubleBuffered  a boolean, true for double-buffering, which
     *        uses additional memory space to achieve fast, flicker-free
     *        updates
     */
    public LinearGradientPanel(boolean isDoubleBuffered) {
        super(isDoubleBuffered);
    }

    /**
     * Creates a new <code>JPanel</code> with a double buffer
     * and a flow layout.
     */
    public LinearGradientPanel() {
        super();
    }



    @Override
    protected void paintComponent(Graphics g) {
        Graphics2D g2 = (Graphics2D) g;

        Rectangle rect = new Rectangle(0, 0, getWidth(), getHeight());
        JideSwingUtilities.fillGradient(g2, rect, startColor, endColor,isVertical());

//        GradientPaint p;
//        //p = new GradientPaint(0, 0, new Color(0xFFFFFF),0, getHeight(), new Color(0xC8D2DE));
//        p = new GradientPaint(0, 0, getStartColor(), 0, getHeight(), getEndColor());
//
//        g2.setPaint(p);
//        g2.fillRect(0, 0, getWidth(), getHeight());

    }

    /**
     * @return the startColor
     */
    public Color getStartColor() {
        return startColor;
    }

    /**
     * @param startColor the startColor to set
     */
    public void setStartColor(Color startColor) {
        this.startColor = startColor;
    }

    /**
     * @return the endColor
     */
    public Color getEndColor() {
        return endColor;
    }

    /**
     * @param endColor the endColor to set
     */
    public void setEndColor(Color endColor) {
        this.endColor = endColor;
    }

    /**
     * @return the vertical
     */
    public boolean isVertical() {
        return vertical;
    }

    /**
     * @param vertical the vertical to set
     */
    public void setVertical(boolean vertical) {
        this.vertical = vertical;
    }
}
