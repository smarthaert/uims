package spell.gui;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import spell.services.SpellChecker;

/**
 * A very simple Gui interacting with the CheckSpeller service
 */
public class SpellCheckerGui extends JFrame {
	/**
	 * Swing component where the user write the passage to check.
	 */
	private JTextField m_passage = null;

	/**
	 * Check button
	 */
	private JButton m_checkButton = null;

	/**
	 * Area where the result is displayed.
	 */
	private JLabel m_result = null;
	/**
	 * Service dependency on the SpellChecker.
	 */
	private SpellChecker m_checker;

	/**
	 * Constructor. Initialize the GUI.
	 */
	public SpellCheckerGui() {
		super();
		initComponents();
		this.setTitle("Spellchecker Gui");
	}

	/**
	 * Initialize the Swing Gui.
	 */
	private void initComponents() {
		java.awt.GridBagConstraints gridBagConstraints;
		m_checkButton = new javax.swing.JButton();
		m_result = new javax.swing.JLabel();
		m_passage = new javax.swing.JTextField();
		setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE); // Stop
																				// Felix
		getContentPane().setLayout(new java.awt.GridBagLayout());
		m_checkButton.setText("Check");
		m_checkButton.addActionListener(new java.awt.event.ActionListener() {
			public void actionPerformed(java.awt.event.ActionEvent e) {
				check();
			}
		});
		gridBagConstraints = new java.awt.GridBagConstraints();
		gridBagConstraints.gridx = 0;
		gridBagConstraints.gridy = 1;
		gridBagConstraints.insets = new java.awt.Insets(2, 2, 2, 2);
		getContentPane().add(m_checkButton, gridBagConstraints);
		m_result.setPreferredSize(new java.awt.Dimension(175, 20));
		gridBagConstraints = new java.awt.GridBagConstraints();
		gridBagConstraints.gridx = 0;
		gridBagConstraints.gridy = 2;
		gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
		gridBagConstraints.insets = new java.awt.Insets(2, 2, 2, 2);
		getContentPane().add(m_result, gridBagConstraints);
		m_passage.setPreferredSize(new java.awt.Dimension(175, 20));
		gridBagConstraints = new java.awt.GridBagConstraints();
		gridBagConstraints.gridx = 0;
		gridBagConstraints.gridy = 0;
		gridBagConstraints.fill = java.awt.GridBagConstraints.HORIZONTAL;
		gridBagConstraints.insets = new java.awt.Insets(2, 2, 2, 2);
		getContentPane().add(m_passage, gridBagConstraints);
		pack();
	}

	/**
	 * Check Button action. Collects the user input and checks it.
	 */
	private void check() {
		String[] result = m_checker.check(m_passage.getText());
		if (result != null) {
			m_result.setText(result.length + " word(s) are mispelled");
		} else {
			m_result.setText("All words are correct");
		}
	}

	/**
	 * Start callback. This method will be called when the instance becomes
	 * valid. It set the Gui visibility to true.
	 */
	public void start() {
		this.setVisible(true);
	}

	/**
	 * Stop callback. This method will be called when the instance becomes
	 * invalid or stops. It deletes the Gui.
	 */
	public void stop() {
		this.dispose();
	}
}