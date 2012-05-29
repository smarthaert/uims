package ipojo.example.hello.impl;

import ipojo.example.hello.DictionaryService;

/**
 * An implementation of the Dictionary service containing English words see
 * DictionaryService for details of the service.
 **/
public class EnglishDictionary implements DictionaryService {
	// The set of words contained in the dictionary.
	String[] m_dictionary = { "welcome", "to", "the", "ipojo", "tutorial" };

	/**
	 * Implements DictionaryService.checkWord(). Determines if the passed in
	 * word is contained in the dictionary.
	 * 
	 * @param word
	 *            the word to be checked.
	 * @return true if the word is in the dictionary, false otherwise.
	 **/
	public boolean checkWord(String word) {
		word = word.toLowerCase();
		// This is very inefficient
		for (int i = 0; i < m_dictionary.length; i++) {
			if (m_dictionary[i].equals(word)) {
				return true;
			}
		}
		return false;
	}
}