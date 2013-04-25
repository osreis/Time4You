class Regex
  EMAIL = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  NAME = /\A([\.A-Za-z\u00C0-\u00FF\s]+)\Z/i
  PHONE = /\A([1-9]{2})([- ]{0,1})(\d{3}|\d{4})([- ]{0,1})(\d{4})\Z/
  MOBILE = /\A([1-9]{2})([- ]{0,1})(\d{4}|\d{5})([- ]{0,1})(\d{4})\Z/
  CPF = /\A\d{11}\Z/
  RG =  /\A\d{8}(X|\d)\Z/
  RG_EXP = /\A[A-Z]{3}\/[A-Z]{2}\Z/
  ZIP_CODE = /\A\d{8}\Z/
end