// sources/debug_script.move
script {
    use Std::Debug;
    fun debug_script(account: signer) {
        Debug::print(&account)
    }
}