package some.thing.whatever;

import library.blabla.LibraryClass;
import library.blabla.LibraryInterface;
import library.blabla.LibrarySuperclass;

public class MainClass extends LibrarySuperclass implements LibraryInterface {

	private int intAttribute;
	private String strAttribute;
	
	public MainClass() {
		this.intAttribute = 0;
		this.strAttribute = null;
	}
	
	public MainClass(int intAttribute, String strAttribute) {
		this.intAttribute = intAttribute;
		this.strAttribute = strAttribute;
	}

	public int getIntAttribute() {
		return intAttribute;
	}

	public String getStrAttribute() {
		return strAttribute;
	}

	public void doSomething() {
		LibraryClass libraryClass = new LibraryClass();
		libraryClass.doSomethingElse(strAttribute);
	}
	
}
