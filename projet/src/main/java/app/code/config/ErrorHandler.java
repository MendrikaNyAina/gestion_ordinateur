package app.code.config;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import app.util.general.exception.CustomException;
import app.util.general.util.ErrorDisplay;

@RestControllerAdvice
public class ErrorHandler {

    @ExceptionHandler(value = CustomException.class)
    public ResponseEntity<Object> customError(CustomException e) {
        e.printStackTrace();
        return new ResponseEntity<>(new ErrorDisplay(HttpStatus.BAD_REQUEST, e.getMessage()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(value = Exception.class)
    public ResponseEntity<Object> customError2(Exception e) {
        e.printStackTrace();
        String s = e.getMessage();
        if (s.contains(":") && s.contains(";")) {
            return new ResponseEntity<>(s.substring(s.indexOf(": ") + 2, s.indexOf(";")),
                    HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(e.getMessage(),
                HttpStatus.BAD_REQUEST);
    }

}
