#include "clang/Frontend/CompilerInstance.h"
#include <iostream>
#include "clang/Basic/SourceManager.h"
#include "clang/Lex/Preprocessor.h"
#include "clang/Basic/TargetOptions.h"

#include "clang/Basic/TargetInfo.h"

using namespace clang;

int main()
{
    CompilerInstance ci;
    DiagnosticConsumer *client = 0;
    ci.createDiagnostics( client, true  );

    // create TargetOptions
    std::shared_ptr<clang::TargetOptions> pTargetOptions = std::make_shared<clang::TargetOptions>();
    pTargetOptions->Triple = llvm::sys::getDefaultTargetTriple();
    // create TargetInfo
    TargetInfo *pti = TargetInfo::CreateTargetInfo(ci.getDiagnostics(), pTargetOptions);
    ci.setTarget(pti);

    ci.createFileManager();  // create FileManager
    ci.createSourceManager(ci.getFileManager()); // create SourceManager
    ci.createPreprocessor(clang::TU_Complete );  // create Preprocessor

    const FileEntry *pFile = ci.getFileManager().getFile("test.c");
    ci.getSourceManager().setMainFileID( 
        ci.getSourceManager().createFileID( pFile,  SourceLocation(), clang::SrcMgr::C_User  )
    ) ;
    ci.getPreprocessor().EnterMainSourceFile();
    ci.getDiagnosticClient().BeginSourceFile(ci.getLangOpts(), &ci.getPreprocessor());
    Token tok;
    do {
        ci.getPreprocessor().Lex(tok);
        if( ci.getDiagnostics().hasErrorOccurred())
            break;
        ci.getPreprocessor().DumpToken(tok);
        std::cerr << std::endl;
    } while ( tok.isNot(clang::tok::eof));
    ci.getDiagnosticClient().EndSourceFile();
}

