package com.mycompany.servicehub.exception;

public class AppException extends Exception {
    
    // එක String එකක් පමණක් ගන්නා Constructor එක මෙතැනට එක් කරන්න
    public AppException(String message) {
        super(message);
    }

    // කලින් තිබූ Constructor එක මෙහි තබා ගන්න (අවශ්‍ය නම්)
    public AppException(String message, String detail) {
        super(message + ": " + detail);
    }
}