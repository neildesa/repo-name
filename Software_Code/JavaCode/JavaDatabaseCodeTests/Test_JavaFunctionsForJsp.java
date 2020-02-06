package JavaDatabaseCodeTests;

import static org.junit.Assert.assertFalse;

import java.util.ArrayList;

import org.junit.Test;

import JavaDatabaseCode.JavaFunctionsForJsp;

public class Test_JavaFunctionsForJsp {
	
	@Test
	public void testAddHospitalDistancesToArray() throws ClassNotFoundException
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC", errorMessage = "";
		int min = 100000, max = 1000000, rating = 0, sort = 1;
		boolean isNotAdding = false;
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		listOfHospitals = JavaFunctionsForJsp.addHospitalDistancesToArray(listOfHospitals, 0.0, 0.0, 8000);
		
		for (int i = 0; i < listOfHospitals.size(); i++) 
		{ 
			if (listOfHospitals.get(i).get(6).isEmpty()) {
				isNotAdding = true;
				errorMessage += "Is not adding distance: i="+i+"\n";
			}
		}
		 
		assertFalse(errorMessage, isNotAdding);
	}
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * doesn't return an empty table.
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaDistanceFiltersCorrectly() throws ClassNotFoundException 
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC", errorMessage = "";
		int minCost = 1, maxCost = 2000000, starRating = 0, typeOfSort = 1;
		double latitude = 0.0, longitude = 0.0, maxRange = 8000;
		boolean outOfRange = false;
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, minCost, maxCost, starRating, typeOfSort);
		
		listOfHospitals = JavaFunctionsForJsp.addHospitalDistancesToArray(listOfHospitals, latitude, longitude, maxRange);
		
		for (int i=0; i<listOfHospitals.size(); i++) {
			if (Double.parseDouble(listOfHospitals.get(i).get(6)) > maxRange) {
				outOfRange = true;
				errorMessage += "Out of Max Range: i="+i+", hospital="+ listOfHospitals.get(i).get(0)+", range="+listOfHospitals.get(i).get(6)+"\n";
			}
		}
		
		assertFalse(errorMessage, outOfRange);
	}
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * doesn't return an empty table.
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaDistanceIsNotEmpty() throws ClassNotFoundException 
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC";
		int min = 100000, max = 1000000, rating = 0, sort = 1;
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		// begin test
		boolean isEmpty = listOfHospitals.isEmpty();
		assertFalse("The list is empty", isEmpty);
	}
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * doesn't return a table with any null or empty string entries.
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaDistanceEntriesNotNull() throws ClassNotFoundException
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC";
		int min = 100000, max = 1000000, rating = 0, sort = 1;
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		// begin test
		boolean thereIsANullEntry = false;
		String errorMessage = "";
		for (int i = 0; i < listOfHospitals.size(); i++) {
			for (int j = 0; j < listOfHospitals.get(i).size(); j++) {
				if (listOfHospitals.get(i).get(j) == "" || listOfHospitals.get(i).get(j) == null)
				{
					thereIsANullEntry = true;
					errorMessage += "null entry at i and j: " + i + ", " + j + "/n";
				}
			}
		}
		
		assertFalse(errorMessage, thereIsANullEntry);
	}
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * does
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaDistanceRowsAreEqualLength() throws ClassNotFoundException
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC";
		int min = 100000, max = 1000000, rating = 0, sort = 1;
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		// being test
		boolean rowsAreNotEqual = false;
		String errorMessage = "";
		for (int i = 0; i < listOfHospitals.size() - 1; i++) 
		{
			if (listOfHospitals.get(i).size() != listOfHospitals.get(i+1).size()) {
				rowsAreNotEqual = true;
				errorMessage += "Rows are not equal at indices i and i+1: " + i + ", " + (i+1) + "/n";
			}
				
		}
		
		assertFalse(errorMessage, rowsAreNotEqual);
	}
	
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * does
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaCostOutOfRange() throws ClassNotFoundException
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC";
		int min = 100000, max = 1000000, rating = 0, sort = 1;
		
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		// being test
		boolean costOutOfRange = false;
		String errorMessage = "";
		for (int i = 0; i < listOfHospitals.size() - 1; i++) 
		{
			if (Double.parseDouble(listOfHospitals.get(i).get(4)) > max || Double.parseDouble(listOfHospitals.get(i).get(4)) < min) {
				costOutOfRange = true;
				errorMessage += "Cost out of range: max=" + max + ", min=" + min + ", cost=" + listOfHospitals.get(i).get(4) + ", i=" + i + "/n";
			}
				
		}
		
		assertFalse(errorMessage, costOutOfRange);
	}
	
	
	/**
	 * Test class for checking that Java call to SQL procedure "SearchByProcedure(String ProcedureName)"
	 * does
	 * 
	 * @throws ClassNotFoundException
	 */
	@Test
	public void testFindHospitalByProcedureViaRatingBelowMin() throws ClassNotFoundException
	{
		String procedureName = "001 - HEART TRANSPLANT OR IMPLANT OF HEART ASSIST SYSTEM W MCC";
		int min = 0, max = 2000000, rating = 0, sort = 1;
		
		ArrayList<ArrayList<String>> listOfHospitals = JavaFunctionsForJsp.findHospitalByProcedure(procedureName, min, max, rating, sort);
		
		// being test
		boolean ratingBelowMin = false;
		String errorMessage = "";
		for (int i = 0; i < listOfHospitals.size() - 1; i++) 
		{
			if (Integer.parseInt(listOfHospitals.get(i).get(5)) > max || Integer.parseInt(listOfHospitals.get(i).get(5)) < min) {
				ratingBelowMin = true;
				errorMessage += "Rating below minimum: min=" + min + ", rating=" + listOfHospitals.get(i).get(5) + ", i=" + i + "/n";
			}
				
		}
		
		assertFalse(errorMessage, ratingBelowMin);
	}
	
	
	@Test
	public void testFindHospitalByProcedureViaCostIsNotEmpty() {
		
	}
}
