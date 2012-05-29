package ipojo.example.hello.client;

import ipojo.example.hello.DictionaryService;
import ipojo.example.hello.SpellChecker;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class SpellCheck implements SpellChecker {
	private DictionaryService m_dictionary;

	/**
	 * Implements SpellChecker.check(). Checks the given passage for misspelled
	 * words.
	 * 
	 * @param passage
	 *            the passage to spell check.
	 * @return An array of misspelled words or null if no words are misspelled.
	 */
	public String[] check(String passage) {
		// No misspelled words for an empty string.
		if ((passage == null) || (passage.length() == 0)) {
			return null;
		}
		List errorList = new ArrayList();
		// Tokenize the passage using spaces and punctuation.
		StringTokenizer st = new StringTokenizer(passage, " ,.!?;:");
		// Loop through each word in the passage.
		while (st.hasMoreTokens()) {
			String word = st.nextToken();
			// Check the current word.
			if (!m_dictionary.checkWord(word)) {
				// If the word is not correct, then add it
				// to the incorrect word list.
				errorList.add(word);
			}
		}
		// Return null if no words are incorrect.
		if (errorList.size() == 0) {
			return null;
		}
		// Return the array of incorrect words.
		return (String[]) errorList.toArray(new String[errorList.size()]);
	}
}