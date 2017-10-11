/**
 *
 */
var getCountriesName = function() {
  
  let result = ["", ""]
  
  let countries = []
  let acronyms  = []
  
  /*
   * Getting countries list at http://www.nationsonline.org/oneworld/country_code_list.htm
   */
  $("td.abs").each(function() {
     countries.push($(this).text()); 
     acronyms.push($(this).next().text());
  })
  
  for (let i = 0; i < countries.length; i++) {
     /*
      * Formmating as vector to insert into an R file.
      * Formmating names as used into Word2Vector.
      */
     let country = countries[i].trim()
     let acronym = acronyms[i].trim()
     
     elements = [",", " (", "of"]
     
     for (let e in elements)
        if (country.indexOf(elements[e]) > -1)
           country = country.split(elements[e])[0]

     result[0] += "'" + country.trim().replace(/ +|-|\'/g, "_") + "',\n"
     result[1] += "'" + acronym + "',\n"
  }
  
  for (let i = 0; i < 2; i++)
     result[i] = result[i].substr(0, result[i].length - 2)

  return result
}