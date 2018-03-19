package com.github.jems;


public class Aggregate  {
    public Contact contact;
    public Adresse adresse;
    
	public Contact getContact() {
		return contact;
	}

	public void setContact(Contact contact) {
		this.contact = contact;
	}

	public Adresse getAdresse() {
		return adresse;
	}

	public void setAdresse(Adresse adresse) {
		this.adresse = adresse;
	}


	public Aggregate withAdresse(Adresse adresse) {
	    if (adresse == null) throw new java.lang.NullPointerException("adresse");
	    return this.adresse == adresse ? this : new Aggregate(this.contact, adresse);
	  }

	public Aggregate withContact(Contact contact) {
	    if (contact == null) throw new java.lang.NullPointerException("contact");
	    return this.contact == contact ? this : new Aggregate(contact, this.adresse);
	  }
	
	/**
	 * @param contact
	 * @param adresse
	 */
	public Aggregate(Contact contact, Adresse adresse) {
		super();
		this.contact = contact;
		this.adresse = adresse;
	}

	/**
	 * 
	 */
	public Aggregate() {
		super();
		// TODO Auto-generated constructor stub
	}



}
