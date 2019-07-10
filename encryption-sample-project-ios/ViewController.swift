import UIKit
import SwiftyRSA

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            // 1.
            let publicKey = try PublicKey(base64Encoded: """
                                          MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVlybjlWfwlNbiHmk7pOSIuKoA24LpE2C+jBY7
                                          Opsev1xKw2XFnw2DPYcbxLQKthvPW/JcLAzRmiphWZgROW9eKHu5uiIiUHQLmfMZDLb8XuYXN6v6
                                          fDhf1NXUdEevP6XS1UJKxB3S7kd3il6qEyJ9PFWJ/aiciKy8HuXx7RjfJQIDAQAB
                                          """)
            let clear = try ClearMessage(string: "my-secret-password", using: .utf8)
            let encrypted = try clear.encrypted(with: publicKey, padding: .OAEP)
            print(encrypted.base64String)
            
            // 2.
            let privateKey2 = try PrivateKey(base64Encoded: """
                                            MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJWXJuOVZ/CU1uIeaTuk5Ii4qgDb
                                            gukTYL6MFjs6mx6/XErDZcWfDYM9hxvEtAq2G89b8lwsDNGaKmFZmBE5b14oe7m6IiJQdAuZ8xkM
                                            tvxe5hc3q/p8OF/U1dR0R68/pdLVQkrEHdLuR3eKXqoTIn08VYn9qJyIrLwe5fHtGN8lAgMBAAEC
                                            gYA4RzWKSZthF54AVBCjL9YK2e6bg/osVe3/whRbFCFn3/aI6hpPzxb2WR+LguV5Yin0SVNU+f2Y
                                            nbd0CJD9ae5LlwaNtpmRJoeqsK8F9epEL++y/v3vetJLDyUao/8fJhsZ1lJXbKcDHp3o6mpztoBn
                                            4u11RovTwddIf4qnmn5dwQJBAPc0MfodGAhy5wvLILlQ3V3yYnBZVTZzoBa2yn/Z0BjXCxx8MA+/
                                            dlAAIfRDOF8hFju1MHy29aQvieFf1CdS6ScCQQCa6ck7tTghia+EFnUzgBkVWFkXOD9YsEEjyeF9
                                            4Uvo5wj+lh4Jm3+cxdgTKj+weVyrBBsqNvxOMlUOT7gM0CzTAkEAl+5tdPJirfaoyBfNAfiQRUhO
                                            dgyBkdjYoH0x0gg1nL62JoixJUygU6TxOWYDBHyaZJIEvfHY4VMSZAD4rD6J6wJAay/L/zY6qmn8
                                            OabYXVQLBwvkSP6wRgteZwbusQzMW1BQlucDzZ38RFtYUJpxCwhOKD5lFWaKWQjWdVqPfL4l5QJA
                                            ZxQGf+OJkWk5oeORHSP1/0edqPXKKIsOtlt6cQl+8u18kThNZRhcoCswAVjUZxGgHbsdT0n/d+le
                                            0tteBJ6jhQ==
                                            """)
            let encrypted2 = try EncryptedMessage(base64Encoded: encrypted.base64String)
            let decryptedMessage = try encrypted.decrypted(with: privateKey2, padding: .OAEP)
            print(try decryptedMessage.string(encoding: .utf8))
        }catch{ 
            print("Unexpected error: \(error).")
        }
        
        AESUtil.test()
    }
    
}
